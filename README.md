# twitch.rb
`twitch` is a small commandline application which will allow you to use the
twitch service without going to the website. The channels which you want to
keep track of should be placed in `${XDG_CONFIG_HOME}/twitch/channels`.
Generally, this resolves to `~/.config/twitch/channels`.

## Installation
A setup script is provided at `/src/setup.sh`. Invoke it as `/src/setup.sh
install` to install the twitch script into `${HOME}/.local/bin`. You can add an
extra argument to set the directory to which the application should be
installed.

## Usage
When invoked without arguments, `twitch` will list all online channels. If you
just want to get a random stream that's currently online, invoke `twitch -s`.
If you want a this stream to start playing in `mpv` (this requires `youtube-dl`
to be installed), you can invoke it as `twitch -s --mpv`.

### Options
- `-g` - Show the name of the game being streamed right now
- `-s` - Show a single, random online channel
- `-u` - Show the URL of the stream. If used in combination with `-s`, returns
  the URL of a random channel instead of the channel name.
- `-v` - Verbose mode, adds a lot of additional output useful for debugging.
- `--mpv` - Open the channel given as argument in `mpv` if it's online. If used
  in combination with `-s`, opens a random online channel in `mpv`.

## Channel list
The list of channels is stored in a plaintext file, 1 channel per line. The
application will look for this list at a set of paths, and uses the first file
it finds. These paths are:
- `${XDG_CONFIG_HOME}/twitch/channels`
- `${HOME}/.config/twitch/channels`

If no file could be found on any of these locations, the program will exit with
an error.

## License
This program is licensed under the GNU GPL version 3

