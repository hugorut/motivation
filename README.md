![alt text](https://travis-ci.org/hugorut/motivation.svg?branch=master "build status")
# Motivation
Ruby gem for command line motivation

Intall the gem with
```shell
gem install hugorut/motivation
```

Then you can run the gem from your command line
```shell
motivation --motivate
```
print out a quote as below:
img

The motivate command also takes a second parameter so that you can specify a author. This parameter is an underscored name of the author such as `steve_jobs` or `c_s_lewis`

Motivation gem also allows you to watch files in a directory and print out a quote when something changes. Usefull for getting through those late night coding sessions. You can run:

```shell
motivate --watch [glob,glob]
```
The second parameter after the watch flag is a list of globs of the files you wish to watch, e.g. ./**/* or ./files/*

Then you can have an output similar to this:
gif