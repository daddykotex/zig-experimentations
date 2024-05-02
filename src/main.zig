const std = @import("std");
const cli = @import("zig-cli");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

var config = struct {
    api_key: []const u8 = undefined,
}{};

var api_key = cli.Option{
    .long_name = "api-key",
    .required = true,
    .help = "api key used to authenticate to apex legends api",
    .value_ref = cli.mkRef(&config.api_key),
};

var app = &cli.App{
    .command = cli.Command{
        .name = "record_matches",
        .options = &.{
            &api_key,
        },
        .target = cli.CommandTarget{
            .action = cli.CommandAction{ .exec = record_matches },
        },
    },
};

pub fn main() !void {
    return cli.run(app, allocator);
}

fn record_matches() !void {
    std.log.debug("server is listening on {s}", .{config.api_key});
}
