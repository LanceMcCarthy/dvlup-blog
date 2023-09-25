---
title: 'DateTime String Format'
date: Fri, 19 Feb 2021 18:38:55 +0000
draft: false
---

This content is from Geekzilla's great post [here](http://www.geekzilla.co.uk/View00FF7904-B510-468C-A2C8-F859AA20581F.htm). I am maintaining it here for HTTPS support and posterity.

0

MM/dd/yyyy

08/22/2006

1

dddd, dd MMMM yyyy

Tuesday, 22 August 2006

2

dddd, dd MMMM yyyy HH:mm

Tuesday, 22 August 2006 06:30

3

dddd, dd MMMM yyyy hh:mm tt

Tuesday, 22 August 2006 06:30 AM

4

dddd, dd MMMM yyyy H:mm

Tuesday, 22 August 2006 6:30

5

dddd, dd MMMM yyyy h:mm tt

Tuesday, 22 August 2006 6:30 AM

6

dddd, dd MMMM yyyy HH:mm:ss

Tuesday, 22 August 2006 06:30:07

7

MM/dd/yyyy HH:mm

08/22/2006 06:30

8

MM/dd/yyyy hh:mm tt

08/22/2006 06:30 AM

9

MM/dd/yyyy H:mm

08/22/2006 6:30

10

MM/dd/yyyy h:mm tt

08/22/2006 6:30 AM

10

MM/dd/yyyy h:mm tt

08/22/2006 6:30 AM

10

MM/dd/yyyy h:mm tt

08/22/2006 6:30 AM

11

MM/dd/yyyy HH:mm:ss

08/22/2006 06:30:07

12

MMMM dd

August 22

13

MMMM dd

August 22

14

yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK

2006-08-22T06:30:07.7199222-04:00

15

yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK

2006-08-22T06:30:07.7199222-04:00

16

ddd, dd MMM yyyy HH':'mm':'ss 'GMT'

Tue, 22 Aug 2006 06:30:07 GMT

17

ddd, dd MMM yyyy HH':'mm':'ss 'GMT'

Tue, 22 Aug 2006 06:30:07 GMT

18

yyyy'-'MM'-'dd'T'HH':'mm':'ss

2006-08-22T06:30:07

19

HH:mm

06:30

20

hh:mm tt

06:30 AM

21

H:mm

6:30

22

h:mm tt

6:30 AM

23

HH:mm:ss

06:30:07

24

yyyy'-'MM'-'dd HH':'mm':'ss'Z'

2006-08-22 06:30:07Z

25

dddd, dd MMMM yyyy HH:mm:ss

Tuesday, 22 August 2006 06:30:07

26

yyyy MMMM

2006 August

27

yyyy MMMM

2006 Augus

DateTime.ToString()

0

MM/dd/yyyy

08/22/2006

The patterns for DateTime.ToString ( 'd' )

0

dddd, dd MMMM yyyy

Tuesday, 22 August 2006

The patterns for DateTime.ToString ( 'D' )

0

dddd, dd MMMM yyyy HH:mm

Tuesday, 22 August 2006 06:30

1

dddd, dd MMMM yyyy hh:mm tt

Tuesday, 22 August 2006 06:30 AM

2

dddd, dd MMMM yyyy H:mm

Tuesday, 22 August 2006 6:30

3

dddd, dd MMMM yyyy h:mm tt

Tuesday, 22 August 2006 6:30 AM

DateTime.ToString ( 'f' ) :

0

dddd, dd MMMM yyyy HH:mm:ss

Tuesday, 22 August 2006 06:30:07

DateTime.ToString ( 'F' ) :

0

MM/dd/yyyy HH:mm

08/22/2006 06:30

1

MM/dd/yyyy hh:mm tt

08/22/2006 06:30 AM

2

MM/dd/yyyy H:mm

08/22/2006 6:30

3

MM/dd/yyyy h:mm tt

08/22/2006 6:30 AM

DateTime.ToString ( 'g' ) :

0

MM/dd/yyyy HH:mm:ss

08/22/2006 06:30:07

DateTime.ToString ( 'G' )

0

MMMM dd

August 22

The patterns for DateTime.ToString ( 'm' ) :

0

ddd, dd MMM yyyy HH':'mm':'ss 'GMT'

Tue, 22 Aug 2006 06:30:07 GMT

The patterns for DateTime.ToString ( 'r' ) :

0

yyyy'-'MM'-'dd'T'HH':'mm':'ss

2006-08-22T06:30:07

The patterns for DateTime.ToString ( 's' ) :

0

yyyy'-'MM'-'dd HH':'mm':'ss'Z'

2006-08-22 06:30:07Z

The patterns for DateTime.ToString ( 'u' ) :

0

dddd, dd MMMM yyyy HH:mm:ss

Tuesday, 22 August 2006 06:30:07

The patterns for DateTime.ToString ( 'U' ) :

0

yyyy MMMM 2006 August

The patterns for DateTime.ToString ( 'y' ) :

Building a custom DateTime.ToString Patterns
--------------------------------------------

The following details the meaning of each pattern character. Note the **K** and **z** character.

**d**

Represents the day of the month as a number from 1 through 31. A single-digit day is formatted without a leading zero

**dd**

Represents the day of the month as a number from 01 through 31. A single-digit day is formatted with a leading zero

**ddd**

Represents the abbreviated name of the day of the week (Mon, Tues, Wed etc)

**dddd**

Represents the full name of the day of the week (Monday, Tuesday etc)

**h**

12-hour clock hour (e.g. 7)

**hh**

12-hour clock, with a leading 0 (e.g. 07)

**H**

24-hour clock hour (e.g. 19)

**HH**

24-hour clock hour, with a leading 0 (e.g. 19)

**m**

Minutes

**mm**

Minutes with a leading zero

**M**

Month number

**MM**

Month number with leading zero

**MMM**

Abbreviated Month Name (e.g. Dec)

**MMMM**

Full month name (e.g. December)

**s**

Seconds

**ss**

Seconds with leading zero

**t**

Abbreviated AM / PM (e.g. A or P)

**tt**

AM / PM (e.g. AM or PM

**y**

Year, no leading zero (e.g. 2001 would be 1)

**yy**

Year, leadin zero (e.g. 2001 would be 01)

**yyy**

Year, (e.g. 2001 would be 2001)

**yyyy**

Year, (e.g. 2001 would be 2001)

**K**

Represents the time zone information of a date and time value (e.g. +05:00)

**z**

With DateTime values, represents the signed offset of the local operating system's time zone from Coordinated Universal Time (UTC), measured in hours. (e.g. +6)

**zz**

As z but with leadin zero (e.g. +06)

**zzz**

With DateTime values, represents the signed offset of the local operating system's time zone from UTC, measured in hours and minutes. (e.g. +06:00)

**f**

Represents the most significant digit of the seconds fraction; that is, it represents the tenths of a second in a date and time value.

**ff**

Represents the two most significant digits of the seconds fraction; that is, it represents the hundredths of a second in a date and time value.

**fff**

Represents the three most significant digits of the seconds fraction; that is, it represents the milliseconds in a date and time value.

**ffff**

Represents the four most significant digits of the seconds fraction; that is, it represents the ten thousandths of a second in a date and time value. While it is possible to display the ten thousandths of a second component of a time value, that value may not be meaningful. The precision of date and time values depends on the resolution of the system clock. On Windows NT 3.5 and later, and Windows Vista operating systems, the clock's resolution is approximately 10-15 milliseconds.

**fffff**

Represents the five most significant digits of the seconds fraction; that is, it represents the hundred thousandths of a second in a date and time value. While it is possible to display the hundred thousandths of a second component of a time value, that value may not be meaningful. The precision of date and time values depends on the resolution of the system clock. On Windows NT 3.5 and later, and Windows Vista operating systems, the clock's resolution is approximately 10-15 milliseconds.

**ffffff**

Represents the six most significant digits of the seconds fraction; that is, it represents the millionths of a second in a date and time value. While it is possible to display the millionths of a second component of a time value, that value may not be meaningful. The precision of date and time values depends on the resolution of the system clock. On Windows NT 3.5 and later, and Windows Vista operating systems, the clock's resolution is approximately 10-15 milliseconds.

**fffffff**

Represents the seven most significant digits of the seconds fraction; that is, it represents the ten millionths of a second in a date and time value. While it is possible to display the ten millionths of a second component of a time value, that value may not be meaningful. The precision of date and time values depends on the resolution of the system clock. On Windows NT 3.5 and later, and Windows Vista operating systems, the clock's resolution is approximately 10-15 milliseconds.

**F**

Represents the most significant digit of the seconds fraction; that is, it represents the tenths of a second in a date and time value. Nothing is displayed if the digit is zero.

**:**

Represents the time separator defined in the current DateTimeFormatInfo..::.TimeSeparator property. This separator is used to differentiate hours, minutes, and seconds.

**/**

Represents the date separator defined in the current DateTimeFormatInfo..::.DateSeparator property. This separator is used to differentiate years, months, and days.

**"**

Represents a quoted string (quotation mark). Displays the literal value of any string between two quotation marks ("). Your application should precede each quotation mark with an escape character (\\).

'

Represents a quoted string (apostrophe). Displays the literal value of any string between two apostrophe (') characters.

**%c**

Represents the result associated with a c custom format specifier, when the custom date and time format string consists solely of that custom format specifier. That is, to use the d, f, F, h, m, s, t, y, z, H, or M custom format specifier by itself, the application should specify %d, %f, %F, %h, %m, %s, %t, %y, %z, %H, or %M. For more information about using a single format specifier, see Using Single Custom Format Specifiers.