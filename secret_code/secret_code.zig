const std = @import("std");

pub fn main() !void {
    var tick_count: i32 = 0;
    var dial_position: i32 = 50;
    
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buffer: [4096]u8 = undefined;
    var file_reader = file.reader(&buffer);

    while(true) {
        const line = try file_reader.interface.takeDelimiter('\n') orelse break;
        
        const dir = line[0];
        const amount = try std.fmt.parseInt(i32, line[1..], 10);

        switch (dir) {
            'L' => {
                const new_pos = dial_position - amount;
                tick_count += @divFloor(dial_position - 1, 100) - @divFloor(new_pos - 1, 100);
                dial_position = @mod(new_pos, 100);           
            },
            'R' => {
                const new_pos = dial_position + amount;
                tick_count += @divFloor(new_pos, 100);
                dial_position = @mod(new_pos, 100);
            },
            else => unreachable,
        }
    }

    std.debug.print("{d}\n", .{tick_count});
}
