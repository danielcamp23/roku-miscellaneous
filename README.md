# roku-miscellaneous
Project to apply pagination concepts

# Search functionality
To do content search, the app is using the OMDb Api (https://www.omdbapi.com/).
It is necessary to add an authorized api key to the queries.
Once you get yours, in the config folder, duplicate the omdb-example.json file and rename it to omdb.json; add your api key in that file

# Roku launch config
Duplicate the .env.example file and rename it to .env
Add your device's IP address and passworkd to this file

# Techical features

The app has two wayt to move to different screens/sections
The Router is aimed to control the navigation in a stack manner, moving forward and backwards
The Tab Controller is to switch between tabs

## Router
The router has a stack to keep track of the views, but only one view is rendered at a time to save memory. Once the user wants to navigate to a new screen, this new screen is stored in the stack but in the view, the previous screen is "unmounted" and the new one is "mounted". Same thing happens when navigating back, the (previous) screen to go to is recovered from the stack and "mounted" back.

## Tab Controller
The tab controller is to switch between tabs. Similarly to the Router, the tabs are recycled and only one tab is rendered at a time

## Screen lifeclycles
The screens three states to handle the screens states

### onCreate
This state is to trigger the LoadContent in the screens.

### onPause
This state is for when the screens are unmounted. Unmounted screens should do certain actions, like stop observing screen content changes. You can refer to the Details screen and VideoPlayer screens. When from the Details screen the user goes to play a video, the Details screen's content node is passed to the Video Player screen, in the later screen, the content node is being updated with video position changes which in theory should trigger content node updates in the Details screen. This is avoid by Pausing the Details page

### onResume
This event is generated when navigating back to the previous screen to resume observers and other flows

## Pagination
The app has two tab sections: HomeTab and SearchTab

### HomeTab
This tab has a RowList with two carousels. Each carousel is paginated with a page size of 10. The pagination is trigger by the navigation, calculating the focused element and the total of elements of that carousel.
There is no vertical pagination due to the limitation of the api used to feed the content

#### SearchTab
This has a MarkupGrid. The pagination adds new items in the grid, every time the user gets to the row before the last one available

## Repositories

## Services

## Content Tasks


