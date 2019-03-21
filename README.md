# watir-docker
This is a docker image for running watir. Currently it only has Chrome installed but there are plans for Firefox in the future.

# Usage
1. In your watir script, use these flags for Chrome `chrome_args = ['--ignore-certificate-errors', '--disable-popup-blocking', '--disable-translate', '--disable-notifications', '--disable-gpu', '--no-sandbox', '--disable-dev-shm-usage']`
2. Then run Chrome like so: `browser = Watir::Browser.new :chrome, options: {args: chrome_args}`
3. Now cd into your project
4. Run the image and mount your project to /app `docker run --rm --network host -it -v $(pwd):/app jcwimer/watir-docker /usr/local/bin/ruby /app/YOUR_SCRIPT.rb`
