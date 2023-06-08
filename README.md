#### Narrative #2

```
As an offline customer
I want the appp to show the latest saved version of my image feed
So I can always enjoy images of my friends
```

##### Scenarious (Acceptance criteria)

```
Given the customer doesn't have connectivity
And there's a cached version of the feed
When the customer requests to see the feed
Then the app should display the latest feed saved

Given the customer doesn't have connectivity
And the cache is empty
When the customer requests to see the feed
Then the app should display an error message
```
