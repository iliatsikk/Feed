# Feed
# feed — image gallery ios app

[![Swift Version](https://img.shields.io/badge/Swift-6%2B-orange.svg)](https://swift.org)  
[![Platform](https://img.shields.io/badge/Platform-iOS%2017.0%2B-blue.svg)](https://developer.apple.com/ios)

## overview

feed is modern ios app built in swiftui that shows a never-ending grid of picsum images. used:

- **async/await** (modern concurrency)  
- simple **pagination** (infinite scroll)  
- **story-style full screen viewer** you can swipe left/right to next/prev and swipe up to dismiss  
- track **seen** & **liked** state per image, with border color and tappable heart
- downsample with **Kingfisher** so memory dont explode  
- tinted pdf app icon + launchscreen storyboard
- introduces local packages for more modularised project

> offline data with SwiftData is **not supported** in this release due deadlines

## features

- two-column grid using `LazyVGrid`  
- infinite loading from `https://picsum.photos/v2/list?page={page}&limit={limit}`  
- each cell triggers `requestMoreItemsIfNeeded` when near end  
- full screen with `FullscreenImageView` and smooth transition  
- left/right swipe to move, up swipe to close (instagram style)  
- seen items get gray border, new get blue border  
- heart button toggles between `heart` & `heart.fill` in red/white  
- launch screen & template icon use single-scale PDF for perfect sizing  

## limitations

- no offline persistence
- no basic error, empty and skeleton UI
- no unit/UI tests yet  
