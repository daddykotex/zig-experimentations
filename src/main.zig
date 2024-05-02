const std = @import("std");
const cli = @import("zig-cli");

var config = struct {
    api_key: []const u8 = undefined,
}{};

var api_key = cli.Option{
    .long_name = "api-key",
    .required = true,
    .help = "api key used to authenticate to apex legends api",
    .value_ref = cli.mkRef(&config.api_key),
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();

    const exec_record_matches: cli.ExecFn = struct {
        fn exec() !void {
            run_record_matches(allocator);
        }
    }.exec;
    var app = &cli.App{
        .command = cli.Command{
            .name = "record_matches",
            .options = &.{
                &api_key,
            },
            .target = cli.CommandTarget{
                .action = cli.CommandAction{ .exec = exec_record_matches },
            },
        },
    };

    return cli.run(app, allocator);
}

fn run_record_matches(alloc: std.mem.Allocator) !void {
    std.log.debug("alloc {}", .{alloc});
}
