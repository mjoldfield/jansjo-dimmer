{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where

import Diagrams.Prelude
import Diagrams.Backend.Cairo.CmdLine
import Text.Printf

import Diagrams.Backend.Cairo

import Diagrams.Segment

-- all sizes in mm

newtype Width  = Width  Double
newtype Height = Height Double

newtype Paper  = Paper (Width, Height)

a4 :: Paper
a4 = Paper (Width 297, Height 210)

inPoints mm = mm / 25.4 * 72.0

onPaper (Paper (Width w, Height h)) d = center d # rectEnvelope (p2 (- 0.5 * w, - 0.5 * h)) (r2 (w,h))

renderOnPaper :: Paper -> FilePath -> Diagram B -> IO ()
renderOnPaper p f = renderCairo f (mkSizeSpec2D (Just wp) (Just hp)) . onPaper p
   where hp = inPoints h
         wp = inPoints w
         (Paper (Width w, Height h)) = p

main = do
          myRend "panel.pdf"  $ bounded design
          myRend "single.pdf" rockerLid

myRend f d = renderOnPaper a4 f (d # lw 0.0762 # lc red)

  

design = makeGrid $ replicate 3 $ replicate 2 rockerLid

bounded :: Diagram B -> Diagram B
bounded d = mconcat [ boundingRect (d # frame 1),  d ]


makeGrid :: [[Diagram B]] -> Diagram B
makeGrid = vsep d . map (center . hsep d . map center)
   where d = 1

basicLid :: Diagram B
basicLid = outline <> screwHoles -- <> rect 63 28
  where screwHoles = mconcat [ holeAt 1.15 x y | y <- [-dy,dy], x <- [-dx,dx] ]
        dx = 0.5 * 61.1
        dy = 0.5 * 26.1

outline :: Diagram B
outline = roundedRect 66.5 31.5 2.7

holeAt :: Double -> Double -> Double -> Diagram B
holeAt r x y  = circle r # translate (r2 (x,y))

m2holeAt = holeAt 1.2 

stdLid = basicLid <> slidePot # translate (r2 (-4.6,0))

slidePot :: Diagram B
slidePot = rect 35.5 2.75
           <> m2holeAt (-20.5) 0.0
           <> m2holeAt   20.5  0.0
           -- <> rect (37.0 + 9.0 * 2) 11

slideSwitch :: Diagram B
slideSwitch = rect 4.19 6.48
              <> m2holeAt 0 dy
              <> m2holeAt 0 (-dy)
  where dy = 0.5 * 17.53

slideLid = stdLid <> slideSwitch # translate (r2 (27.25,0))  

rockerSwitch :: Diagram B
rockerSwitch = rect 6.8 19.2
               -- <> rect 9 21

rockerLid = stdLid <> rockerSwitch # translate (r2 (27.25,0))  
