package main

import (
	"fmt"

	"camerondugan.com/aoc2024/solutions"
)

type problem struct {
	id     string
	solver func(string) int
}

func main() {
	problems := []problem{
		{id: "2.1", solver: solutions.Solve2p1},
		{id: "2.2", solver: solutions.Solve2p2},
		{id: "3.1", solver: solutions.Solve3p1},
	}
	list_problems(problems)
	fmt.Print("Run problem: ")
	fmt.Println("SLEEP is good :)")
	var user_input string
	_, err := fmt.Scanln(&user_input)
	errCheck(err)
	for _, problem := range problems {
		if user_input == problem.id {
			println("Found a match!")
			problem.solver("")
		}
	}
}

func list_problems(problems []problem) {
	fmt.Print("Problems: ")
	for _, prob := range problems {
		fmt.Print(prob.id)
		fmt.Print(" ")
	}
	fmt.Println()
}

func errCheck(err error) {
	if err != nil {
		fmt.Println(err)
		panic(err)
	}
}
