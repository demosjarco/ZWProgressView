ZWProgressView
==============
So I had a quesion on github on how to make a UIProgressView and have a UILabel in the middle that would reflect the percentage, but have that text change color dude to the overlapping when the progress bar passed it. so this guy named <a href="http://stackoverflow.com/users/860967/zhang">Zhang</a> on Stack Overflow was kind enough and put something together. It worked really nice, but I wanted to add more features and functionality to it. So I want to give credit to him for the original code. <a href="http://stackoverflow.com/questions/24275603/uilabel-over-uiprogressview-with-multiple-colors">Here</a> is the original post with the answer.

Required<br />
Setup the ZWProgressView as a normal UIView with a frame. Then set the progress value of it to a float value of the percentage (1.0 = 100%, 0.0 = 0%).

```Objective-C
ZWProgressView *progressView = [[ZWProgressView alloc] initWithFrame:CGRectMake(x, y, width, height)];
progressView.progress = 0.47f;
```

Optional<br />
The setContainerBackgroundColor: methods set the background color of the progress bar (the part that hasn't been 'filled' yet).<br />
The setProgressBarFillColor: method sets the fill color of the progress bar.<br />
Note: Both methods take an instance of UIColor as a parameter.

```Objective-C
[progressView setContainerBackgroundColor:[UIColor whiteColor]];
[progressView setProgressBarFillColor:[UIColor blueColor]];
```
