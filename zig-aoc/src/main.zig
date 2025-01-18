const std = @import("std");
const solver = @import("solution3.1.zig");

pub fn main() !void {
    const log = std.log;
    log.debug("memees", .{});
    const output1 = solver.solvep1("input/day2.txt");
    const output2 = solver.solvep2("input/day2.txt");
    log.debug("sum1: {!}", .{output1});
    log.debug("sum2: {!}", .{output2});
    var bw = std.io.bufferedWriter(std.io.getStdOut().writer());

    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});
    try bw.flush(); // don't forget to flush!
}
