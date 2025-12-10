const std = @import("std");

pub fn main() !void {
    const f = try std.fs.cwd().openFile("input.txt", .{});
    defer f.close();

    var buf:[4096]u8 = undefined;
    var reader = f.reader(&buf);
    var total: u64 = 0;

    while(true) {
        const line = try reader.interface.takeDelimiter(',') orelse break;
        var iterator = std.mem.splitAny(u8, line, "-");

        const first_str = iterator.next() orelse return;
        const last_str = iterator.next() orelse return;

        const trimmed = std.mem.trim(u8, last_str, "\n\r \t");

        const first_num: u64 = try std.fmt.parseInt(u64, first_str, 10);
        const last_num: u64 = try std.fmt.parseInt(u64, trimmed, 10);

        var i: u64 = first_num;
        while(i <= last_num) : (i += 1) {
            if(isInvalid(i)) total += i;
        }

        continue;
    }

    std.debug.print("{d}\n", .{total});
}

fn isInvalid(n:u64) bool {
    var buf:[32]u8 = undefined;
    const n_str = std.fmt.bufPrint(&buf, "{d}", .{n}) catch return false;
    
    var slice: usize = 1;
    while(slice < n_str.len) : (slice+= 1) {
        if(n_str.len % slice != 0) continue;
        const first = n_str[0..slice];
        var curr_slice:usize = slice; 

        while(curr_slice != n_str.len) : (curr_slice += slice) {
            if(!std.mem.eql(u8, first, n_str[curr_slice..curr_slice + slice])) break;
        }

        if(curr_slice == n_str.len) return true;
    }
    return false;
}

