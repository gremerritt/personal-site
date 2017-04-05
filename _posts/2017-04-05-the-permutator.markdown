---
layout: post
title: "The Permutator"
date: 2017-04-05 00:18:40 -0400
categories: code utilities
---
Today at work I found myself with an interesting problem. We have some command-line testing utilities that we use to test pages on our web app. Something along the lines of:

{% highlight bash %}
$ test www.mysite.com/home
{% endhighlight %}

I was working on an issue that had to do with the way different url parameters interacted. The bug I was working on had to do with a single combination of two different parameters, and so I was able to test my fix directly on that URL. However, I wanted a way to test _all_ of the different combinations of parameters that could be passed in.

Obviously one solution would be to add functionality to our testing suite to allow running permutations. That would be excellent (and will hopefully come sometime in the future!) but I wanted the functionality now. Thus, I wrote up a general purpose script that can run any permutations of any command line utility. The full script can be found below.

The script runs as follows:

{% highlight bash %}
$ permutator -f a.txt -f b.txt command -whatever -options {0} {1}
{% endhighlight %}

The files are simple text files and each contains all of the possible values for their respective parameters. You can have as many as you want, but note that the number of commands that will be run is `O(n^m)` where `n` is the number of options in the files and `m` is the number of file.

The `{#}`s are the placeholders for the values - they must be 0-indexed. Ideally there should be one for each of your files. If you have less the extra files will be ignored, and if you have more you'll have `{#}` literals in your command.

A couple other random notes - it uses ruby's `pty` package so that it runs the commands exactly as if you were running it manually on the command line, colors and all. You can also pass in a `-p` (preview) flag and the script will output all of the different commands that it _would_ run.

So let's see it in action:

{% highlight bash %}
$ ~/dev › cat a.txt
a_1
a_2
a_3
$ ~/dev › cat b.txt
b_1
b_2
b_3
$ ~/dev › ./permutator -f a.txt -f b.txt echo {0} {1}
a_1 b_1
a_1 b_2
a_1 b_3
a_2 b_1
a_2 b_2
a_2 b_3
a_3 b_1
a_3 b_2
a_3 b_3
{% endhighlight %}

Happy permutating!

<script src="https://gist.github.com/gremerritt/a36377319f57cdeaf141e329d63de2c0.js"></script>
