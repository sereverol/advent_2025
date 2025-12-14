const std = @import("std");

const BatPack = struct { left_cell: i32, right_cell: i32 };

pub fn main() !void {
    const f = try std.fs.cwd().openFile("input.txt", .{});
    defer f.close();

    var buf:[4096]u8 = undefined;
    var reader = f.reader(&buf);
    var total: i32 = 0;


    while(true) {
        const line = try reader.interface.takeDelimiter('\n') orelse break;
        var best:i32 = 0;
    
        var i: usize = 0;
        while (i < line.len - 1) : (i += 1) {
            const first_digit: i32 = @intCast(line[i] - '0');

            var max_number:i32 = 0;

            var j: usize = i + 1;
            while (j < line.len) : (j += 1) {
                const d: i32 = @intCast(line[j] - '0');
                if(d > max_number) {
                    max_number = d;
                }
            }
            
            const pair = first_digit * 10 + max_number;
            if (pair > best) {
                best = pair;
            }

        }
        
        total += best;

    }

    std.debug.print("{d}\n", .{total});
}
