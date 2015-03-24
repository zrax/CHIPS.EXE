package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"os"
	"sort"
	"strconv"
	"strings"
)

type Line struct {
	Addr      uint32
	Text      string
	Mnemonic  string
	IsJump    bool
	IsTarget  bool
	Label     int
	JumpLabel int
	JumpDest  uint32
}

type Jump struct {
	Dest uint32
	Line int
}

func main() {
	start := flag.Uint("start", 0, "start address")
	single := flag.Bool("one", false, "disassemble a single function")
	flag.Parse()

	r := bufio.NewReader(os.Stdin)
	var lines []Line
	var jumps []Jump
	var errors int
	var lastAddr uint32

	breaking := false
	for number := 1; ; number++ {
		line, err := r.ReadString('\n')
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println(err)
			return
		}
		var (
			addr     uint32
			code     string
			mnemonic string
			arg1     string
			arg2     string
		)
		n, err := fmt.Sscanf(
			stripComment(line),
			"%x %s %s %s %s",
			&addr,
			&code,
			&mnemonic,
			&arg1,
			&arg2,
		)

		//if err != nil && err != io.EOF && err != io.ErrUnexpectedEOF {
		//	fmt.Println(err)
		//	errors++
		//}

		if n < 3 {
			lines = append(lines, Line{
				Addr:     lastAddr,
				Text:     line,
				Mnemonic: mnemonic,
			})
			continue
		}
		lastAddr = addr
		if uint(addr) < *start {
			lines = lines[:0]
			continue
		}

		if breaking && mnemonic != "nop" {
			break
		}

		//fmt.Print(line[24:])
		if isJump(mnemonic) {
			var jumpDest uint64
			var text string
			if n == 4 {
				jumpDest, err = strconv.ParseUint(arg1, 0, 32)
				text = fmt.Sprintf("    %s", mnemonic)

			} else if n == 5 && arg2[0] == '0' {
				jumpDest, err = strconv.ParseUint(arg2, 0, 32)
				text = fmt.Sprintf("    %s %s", mnemonic, arg1)
			}

			if err != nil {
				fmt.Fprintf(os.Stderr, "line %d: %v\n", number, err)
				errors++
				continue
			}
			lines = append(lines, Line{
				Addr:     addr,
				Text:     text,
				Mnemonic: mnemonic,
				IsJump:   true,
				JumpLabel: -1,
				JumpDest: uint32(jumpDest),
			})
			jumps = append(jumps, Jump{
				Dest: uint32(jumpDest),
				Line: len(lines) - 1,
			})
		} else {
			lines = append(lines, Line{
				Addr:     addr,
				Mnemonic: mnemonic,
				Text:     line[24:],
			})
		}

		if *single && mnemonic == "retf" {
			breaking = true
		}
	}

	if errors > 0 {
		return
	}

	sort.Sort(ByDest(jumps))

	var label int
	for _, j := range jumps {
		line, ok := findLine(lines, j.Dest)
		if !ok {
			fmt.Fprintf(os.Stderr, "warning: no jump target %x\n", j.Dest)
			continue
		}
		if !line.IsTarget {
			line.IsTarget = true
			line.Label = label
			label++
		}
		lines[j.Line].JumpLabel = line.Label
	}

	for _, line := range lines {
		if line.IsTarget {
			fmt.Printf(".label%d: ; %x\n", line.Label, line.Addr)
		}
		if line.IsJump {
			if line.JumpLabel >= 0 {
				fmt.Printf("%s .label%d ; %s\n", line.Text, line.JumpLabel, arrow(int32(line.JumpDest - line.Addr)))
			} else {
				fmt.Printf("%s %#x\n", line.Text, line.JumpDest)
			}
		} else if line.Mnemonic == "call" {
			s := strings.TrimRight(line.Text, "\n")
			fmt.Printf("%s ; %x\n", s, line.Addr)
		} else {
			fmt.Print(line.Text)
		}
	}
	if *single {
		fmt.Println()
		fmt.Printf("; %x\n", lastAddr)
	}
}

func isJump(s string) bool {
	return s != "" && s[0] == 'j'
}

func findLine_(lines []Line, addr uint32) (*Line, bool) {
	lo, hi := 0, len(lines)
	for lo < hi {
		mid := lo + (hi-lo)/2
		if lines[mid].Addr == addr {
			return &lines[mid], true
		}
		if lines[mid].Addr < addr {
			lo = mid + 1
		} else {
			hi = mid
		}
	}
	return nil, false
}

func findLine(lines []Line, addr uint32) (*Line, bool) {
	for i := range lines {
		if lines[i].Addr == addr {
			return &lines[i], true
		}
	}
	return nil, false
}

// ByDest implements sort.Interface
type ByDest []Jump

func (s ByDest) Len() int           { return len(s) }
func (s ByDest) Less(i, j int) bool { return s[i].Dest < s[j].Dest }
func (s ByDest) Swap(i, j int)      { s[i], s[j] = s[j], s[i] }

func stripComment(s string) string {
	idx := strings.LastIndex(s, "//")
	if idx >= 0 {
		s = s[:idx]
	}
	return s
}

func arrow(n int32) string {
	if n < 0 {
		return "↑"
	}
	return "↓"
}
