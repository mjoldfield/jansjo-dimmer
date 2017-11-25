# Jansjö dimmer

This repository relates to a simple PWM dimmer designed ostensibly for
the Ikea Jansjö LED lamp.

## data

Experimental data from the prototypes:

### dutycycle-f

The variation of frequency with duty-cycle.

    $ gnuplot plotit.scr
    $ open out.pdf

### current-t

Various screen captures from the scope showing current against time.

## datasheets

Manufacturers' data for parts in the project.

## gerbers

PCB files as sent to the board manufacturer (Elecrow).

## kicad

PCB/schematic files

## panel

A Haskell program to generate a PDF to laser cut the front panel.

Given [stack](https://docs.haskellstack.org/en/stable/README/):

    $ stack build
    $ stack exec pdf-exe
    $ open *.pdf

