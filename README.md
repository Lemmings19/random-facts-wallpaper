random-facts-wallpaper
=============

Automatically generated, random fact wallpaper.

![photos-js-screenshot](http://taeram.github.io/media/zen-wallpaper.png)

Requirements
============

* A [GitHub](https://github.com/) account
* PHP.
* Linux, or possibly OSX.

### First Time Setup

Simply run the script, and it will install all necessary dependencies, and generate a GitHub OAuth token.

The script requires a single argument, which is the path that the auto generated wallpaper will be saved to.

```bash
./random-facts-wallpaper.sh $HOME/Pictures
```

Once the script has been run for the first time, you'll find a `random-facts-wallpaper.png` file in your `$HOME/Pictures` directory,
assuming that's the path you used.

Now, set the wallpaper as your desktop background. 

When you want a new random fact, simply re-run the script with the same arguments. The script will overwrite the 
original `random-facts-wallpaper.png` file, and Ubuntu will detect the change and automatically show the new wallpaper.

---

Many thanks to [Taeram](https://github.com/taeram/) for writing the script.
