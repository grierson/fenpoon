# Fenpoon

Clone of [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) written in fennel

I know the name is awful. FENnel + harPOON.

## Why

I wanted to create a nvim plugin + use fennel

## Should I use it?

No use [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)

## Setup

Lazy
```
"grierson/fenpoon"
```

## Commands

### Mark file

Add a file to your marks

```
:lua require("fenpoon.main").mark()
```

### Telescope

List marks and view mark index

```
:lua require("fenpoon.main").telescope()
```

`<c-d>` on selection within Telescope will delete the mark

### Select a mark

Select a specific mark

```
:lua require("fenpoon.main").select(N)
```

Usally map 1,2,3,4 to frequent keys

```
n <cmd>:lua require("fenpoon.main").select(1)<CR>
e <cmd>:lua require("fenpoon.main").select(2)<CR>
i <cmd>:lua require("fenpoon.main").select(3)<CR>
o <cmd>:lua require("fenpoon.main").select(4)<CR>
```

### Delete mark

Delete specific mark

```
:lua require("fenpoon.main").delete(N)
```

## TODO

* Cache marks
* Make marks project specific
