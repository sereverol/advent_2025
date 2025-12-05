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
                dial_position = @mod(dial_position - amount, 100);
                if(dial_position == 0) tick_count += 1;
            },
            'R' => {
                dial_position = @mod(dial_position + amount, 100);
                if(dial_position == 0) tick_count += 1;
            },
            else => unreachable,
        }
    }
 
    std.debug.print("{d}\n", .{tick_count});
}
