import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  day1()
}

const separator = "   "

pub fn day1() {
  let filepath = "puzzleinput/1-1.txt"
  let content = result.unwrap(simplifile.read(filepath), "failed to read file")
  io.debug(content)
  let lines = string.split(content, "\n")
  let num_combos =
    lines
    |> list.map(string.split(_, separator))
    |> split_sort
    |> list.map(list.sort(_, int.compare))
  let assert [list1,list2] = num_combos
  let num_combos = num_combos
    |> list.interleave
    |> list.sized_chunk(2)
  let ans1 = num_combos
    |> list.fold(0, fn (sum:Int, pair) -> Int {
      case pair {
        [a,b]->{
        let tmp = sum+int.absolute_value(a-b)
          tmp
        }
        _ -> sum
      }
    })
    |> io.debug
  let ans2 = num_combos
    |> list.fold(0, fn (sum:Int, pair) -> Int {
      case pair {
        [a,_]->{
        let tmp = sum+{a*list.count(list2,fn(x) {x==a})}
          tmp
        }
        _ -> sum
      }
    })
    |> io.debug
  //io.println("ans "<>int.to_string(ans))
}

pub fn split_sort(list: List(List(String))) -> List(List(Int)) {
  case list {
    [[x, y], ..rest] -> {
      let assert [[..a],[..b]]=split_sort(rest)
      [[unwrap_int(x),..a], [unwrap_int(y),..b]]
    }
    _ -> [[], []]
  }
}

fn unwrap_int(s:String) -> Int {
  result.unwrap(int.parse(s),0)
}
