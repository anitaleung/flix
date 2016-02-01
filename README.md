# Project 1 - Flix

Flix is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Popup with more info when tapping on a movie poster
2. Integrate trailers?

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

**Stage 1** | **Stage 2**
----------------------------
<img src='https://raw.githubusercontent.com/anitaleung/flix/master/gifs/stage1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' /> | <img src='https://raw.githubusercontent.com/anitaleung/flix/master/gifs/stage2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

**Stage 3**

Note: The searchbar doesn't show up correctly in the gif for some reason. Screenshots are provided because of this.

<img src='https://raw.githubusercontent.com/anitaleung/flix/master/gifs/stage3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://raw.githubusercontent.com/anitaleung/flix/master/Screenshots/screenshot1.png' title='Screenshot' width='' alt='Screenshot' />

<img src='https://raw.githubusercontent.com/anitaleung/flix/master/Screenshots/screenshot2.png' title='Screenshot' width='' alt='Screenshot' />

<img src='https://raw.githubusercontent.com/anitaleung/flix/master/Screenshots/screenshot2.png' title='Screenshot' width='' alt='Screenshot' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

There was a typo in the MovieCollectionViewCell identifier which caused a "NSInternalInconsistencyException" that took almost an hour to solve. :)

## License

    Copyright [2016] [Anita Leung]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.