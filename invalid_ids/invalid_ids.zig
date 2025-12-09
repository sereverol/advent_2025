const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [4096]u8 = undefined;
    var file_reader = file.reader(&buffer);
    var invalidIdsTotal: u64 = 0;

    while (true) {
        const idRange = try file_reader.interface.takeDelimiter(',') orelse break;
        var iterator = std.mem.splitAny(u8, idRange, "-");

        const startStr = iterator.next() orelse return;
        const endStr = iterator.next() orelse return;

        const trimmed = std.mem.trim(u8, endStr, "\n\r \t");

        const start = try std.fmt.parseInt(u64, startStr, 10);
        const end = try std.fmt.parseInt(u64, trimmed, 10);

        var i = start;
        while(i <= end) : (i += 1) {
            if (isInvalid(i)) invalidIdsTotal += i;
        }

    }

    std.debug.print("{d}", .{invalidIdsTotal});
}

fn isInvalid(num: u64) bool {
    var buf: [20]u8 = undefined;
    const numStr = std.fmt.bufPrint(&buf, "{d}", .{num}) catch return false;

    if (numStr.len % 2 != 0) return false;

    const half = numStr.len / 2;
    const firstHalf = numStr[0..half];
    const secondHalf = numStr[half..];

    return std.mem.eql(u8, firstHalf, secondHalf);

}
