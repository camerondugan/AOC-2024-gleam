const std = @import("std");
const testing = std.testing;

pub fn solvep1(path: []const u8) !u64 {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;

    var sum: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var safe = true;
        var first = true;
        var second = true;
        var last_num: u64 = 0;
        var is_increasing = true;
        std.debug.print("{s}\n", .{line});
        var numStrs = std.mem.split(u8, line, " ");
        while (numStrs.next()) |numStr| {
            const num = std.fmt.parseInt(u64, numStr, 10) catch 0;
            if (first) {
                first = false;
                last_num = num;
                continue;
            }
            std.debug.print("{d} - {d} \n", .{ num, last_num });
            var diff: u64 = 0;
            var this_is_increasing = true; //unused val
            if (num > last_num) {
                diff = num - last_num;
                this_is_increasing = true;
            } else {
                diff = last_num - num;
                this_is_increasing = false;
            }
            std.debug.print("{d} - {d} = {d} \n", .{ num, last_num, diff });
            // setup and detect direction change
            if (second) {
                is_increasing = this_is_increasing;
                second = false;
            } else if (this_is_increasing != is_increasing) {
                safe = false;
                std.debug.print("dir changed\n", .{});
                break;
            }
            // abs diff
            if (diff < 0) {
                diff = -diff;
            }
            if (diff > 3 or diff == 0) {
                safe = false;
                std.debug.print("diff too big or zero: {}\n", .{diff});
                break;
            }
            last_num = num;
        }
        // safe, if not safe it skips this with continue statement
        if (safe) {
            sum += 1;
            std.debug.print("sum: {}\n", .{sum});
        }
    }
    return sum;
}

pub fn solvep2(path: []const u8) !u64 {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;

    var sum: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var safe = true;
        var first = true;
        var second = true;
        var last_num: u64 = 0;
        var problemDampenerActivated = false;
        var is_increasing = true;
        std.debug.print("{s}\n", .{line});
        var numStrs = std.mem.split(u8, line, " ");
        while (numStrs.next()) |numStr| {
            const num = std.fmt.parseInt(u64, numStr, 10) catch 0;
            if (first) {
                first = false;
                last_num = num;
                continue;
            }
            var diff: u64 = 0;
            var this_is_increasing = true; //unused val
            if (num > last_num) {
                diff = num - last_num;
                std.debug.print("{d} - {d} = {d} \n", .{ num, last_num, diff });
                this_is_increasing = true;
            } else {
                diff = last_num - num;
                std.debug.print("{d} - {d} = {d} \n", .{ last_num, num, diff });
                this_is_increasing = false;
            }
            // setup and detect direction change
            if (second) {
                is_increasing = this_is_increasing;
                second = false;
            } else if (this_is_increasing != is_increasing) {
                if (problemDampenerActivated) {
                    safe = false;
                    std.debug.print("dir changed\n", .{});
                    break;
                } else {
                    problemDampenerActivated = true;
                    second = true;
                    continue; //skip updating number and remaining checks
                }
            }
            // abs diff
            if (diff < 0) {
                diff = -diff;
            }
            if (diff > 3 or diff == 0) {
                if (problemDampenerActivated) {
                    safe = false;
                    std.debug.print("diff too big or zero: {}\n", .{diff});
                    break;
                } else {
                    problemDampenerActivated = true;
                    second = true;
                    continue; //skip updating number and remaining checks
                }
            }
            last_num = num;
        }
        // safe, if not safe it skips this with continue statement
        if (safe) {
            sum += 1;
            std.debug.print("sum: {}\n", .{sum});
        }
    }
    return sum;
}

test "example input part 1" {
    const ans = solvep1("./test_input/day2.txt");
    std.log.debug("{!}", .{ans});
    try testing.expectEqual(2, ans catch 0);
}

test "example input part 2" {
    const ans = solvep2("./test_input/day2.txt");
    std.log.debug("{!}", .{ans});
    try testing.expectEqual(6, ans catch 0);
}
