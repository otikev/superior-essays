# SLIMM - Sling Monitoring & Mapping

Monitor Sling changes and map to Clones and Transformers using high accuracy guesses.
```
Html:<div><span>hello world<span/><div/>
Sling: <div><span>hello world
bridge thread: <div><span>
content: hello world
```
##Terms:
Content - the data that we are monitoring

Bridge Thread - the pattern that points us to the content

Sling - the name of a pair composed of Content and Bridge Thread

Split - where the bridge thread to a specific content changes (the content remaining unchanged)

Fluff - constantly changing bridge thread suffix after every Split

Mutation - When the content for a specific bridge thread changes (the bridge thread remaining unchanged)

Clone - The new content and bridge thread after a split

Transformer - the new content after a Mutation


##EXAMPLE
```
<div><span>hello world<span/><div/>
```
changes to
```
<div><div><div>hello world<div/><div/><div/>
```

Split occurred at:
```
<span>
```
Giving a final bridge thread as
```
<div><div><div>
```
To optimize the search for the clone source we look for a split in the bridge thread that is closest to the clone.