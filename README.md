# Mac Time Tracker to Tyme 2 (mtttt2) migration app

Application to help migrate time tracking data from [Mac Time Tracker](https://github.com/rburgst/time-tracker-mac) to [Tyme 2](http://tyme-app.com/).

## Installation

[Download the lastest binary release](https://github.com/doubledrones/mac-time-tracker-to-tyme-2/releases) or build from source:

```bash
brew install crystal
crystal build src/mtttt2.cr
```

## Usage

```bash
./mtttt2 MacTimeTrackerData.csv output_for_tyme2.csv
```

## Development

Watch changes and run spec:

```bash
brew install watchman # https://facebook.github.io/watchman
watchman-make -p '**/*.cr' --make=crystal -t spec
```

### Formats

Mac Time Tracker:

```csv
"Project";"Task";"Date";"Start";"End";"Duration";"Comment"
"Foo";"Bar";"2016-06-06";"2016-06-06 09:21:07";"2016-06-06 17:29:07";"08:08:00";""
```

Tyme 2:

```csv
type;date;unix_start;unix_end;day;start;end;category;project;task;subtask;amount;amount_decimal;rate;sum;rounding_minutes;rounding_method;note
timed;04/08/16;1470293280;1470293880;Thursday;08:48;08:58;;Foo;Bar;;00:10;0,17;;;1;NEAREST;%
```
