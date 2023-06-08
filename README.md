### Story: Customer requests to see their image feed

#### Narrative #1

```
As an online customer
I want to the app to automatically load my latest image feed
So I can always enjoy the newest images of my friends
```

##### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
 When the customer requests to see their feed
 Then the app should display the latest feed from remote
  And replace the cache with the new feed
```

#### Narrative #2

```
As an offline customer
I want the appp to show the latest saved version of my image feed
So I can always enjoy images of my friends
```

##### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there's a cached version of the feed
  And the cache is less then seven days old
 When the customer requests to see the feed
 Then the app should display the latest feed saved
 
 Given the customer doesn't have connectivity
  And there's a cached version of the feed
  And the cache is seven days old or more
 When the customer requests to see the feed
  Then the app should display an error message

Given the customer doesn't have connectivity
  And the cache is empty
 When the customer requests to see the feed
 Then the app should display an error message
```

## Use Cases

### Load Feed Remote Use Case

#### Data:
- URL

#### Primary course (happy path):
1. Execute "Load Feed Items" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates feed items from valid data.
5. System delivers feed items.

#### Invalid data - error course (sad path):
1. System delivers error.

#### No connectivity - error course (sad path):
1. System delivers error.
