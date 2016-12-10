There is a very good Library called [SDWebImage][1].It provides an async image downloader.

But some time as loading user's profile avatar, we need a round circle image.

So I wrote this demo to show how make round image after SDWebImage complet the download process.

Just a short demo,that you can use it as 

[yourImageView round_setImageWithURL:YourURL placeholderImage:nil options:0 progress:nil completed:nil];


[1]: https://github.com/rs/SDWebImage
