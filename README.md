# Shelley-VM

A ready-to-use development environment with [Shelley](https://github.com/boldsoftware/shelley), an AI coding assistant powered by Claude. Describe what you want to build, and Shelley writes the code for you.

## What you'll need

- A Mac (Intel or Apple Silicon)
- About 15 minutes for setup
- An Anthropic API key (we'll show you how to get one)

## Step 1: Get an Anthropic API key

You'll need an API key to use Claude (the AI that powers Shelley).

If you are working at [OOZOU](https://oozou.com), you can ask @consti and he'll help you get one.

If you don't (yet ツ) work at OOZOU:

1. Go to [console.anthropic.com](https://console.anthropic.com/)
2. Create an account or sign in
3. Click "Get API Keys" in the left sidebar
4. Click "Create Key"
5. Give it a name (e.g., "Shelley") and click "Create Key"
6. **Copy the key and save it somewhere safe** - you won't be able to see it again

Your API key looks something like: `sk-ant-api03-xxxxx...`

## Step 2: Install Docker Desktop

Docker is the software that runs Shelley on your computer.

1. Go to [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
2. Click the download button for Mac
3. Open the downloaded `.dmg` file
4. Drag Docker to your Applications folder
5. Open Docker from your Applications folder
6. If asked, grant the permissions Docker needs
7. Wait until you see a whale icon in your menu bar (top of screen) - this means Docker is running

## Step 3: Download Shelley-VM

1. Go to [github.com/oozou/shelley-vm](https://github.com/oozou/shelley-vm)
2. Click the green **Code** button
3. Click **Download ZIP**
4. Find the downloaded file (usually in your Downloads folder) and double-click to unzip it
5. You should now have a folder called `shelley-vm-main`

## Step 4: Open Terminal

Terminal is an app on your Mac that lets you run commands.

1. Press **Command + Space** to open Spotlight search
2. Type **Terminal** and press Enter
3. A window with a command prompt will open

## Step 5: Navigate to the Shelley-VM folder

In Terminal, you need to go to the folder you downloaded. Type this command and press Enter:

```
cd ~/Downloads/shelley-vm-main
```

If you moved the folder somewhere else, you'll need to adjust the path. You can also type `cd ` (with a space after it) and then drag the folder into Terminal - it will fill in the path for you.

## Step 6: Build Shelley-VM

This creates the Shelley environment on your computer. Type this command and press Enter:

```
docker build -t shelley-vm .
```

**Don't forget the period at the end!** This will take a few minutes the first time.

You'll see lots of text scrolling by. Wait until you see "Successfully tagged shelley-vm:latest" or similar.

## Step 7: Start Shelley-VM

Now start Shelley with this command. **Replace `your-api-key-here` with the API key you saved in Step 1:**

```
docker run -d --name shelley-vm --privileged -p 9000:9000 -p 8000:8000 -e ANTHROPIC_API_KEY=your-api-key-here shelley-vm
```

For example, if your API key is `sk-ant-api03-abc123`, the command would be:

```
docker run -d --name shelley-vm --privileged -p 9000:9000 -p 8000:8000 -e ANTHROPIC_API_KEY=sk-ant-api03-abc123 shelley-vm
```

## Step 8: Start building your app

Open your web browser and go to:

**[http://localhost:9000](http://localhost:9000)**

You should see the Shelley interface. Start building your app by describing what you want to create!

When Shelley creates a web app for you, you can view it at [http://localhost:8000](http://localhost:8000).

## Everyday usage

### Starting Shelley (after restarting your computer)

1. Make sure Docker Desktop is running (whale icon in menu bar)
2. Open Terminal
3. Run: `docker start shelley-vm`
4. Go to [http://localhost:9000](http://localhost:9000)

### Stopping Shelley

Open Terminal and run:

```
docker stop shelley-vm
```

## Troubleshooting

### "Cannot connect to the Docker daemon"

Docker Desktop isn't running. Open Docker from your Applications folder and wait for the whale icon to appear in your menu bar.

### "The name shelley-vm is already in use"

You already have a Shelley container. Either start the existing one:

```
docker start shelley-vm
```

Or remove it and create a new one:

```
docker rm shelley-vm
```

Then run the `docker run` command from Step 7 again.

### "Error response from daemon: Ports are not available"

Another app is using port 9000 or 8000. You can use different ports:

```
docker run -d --name shelley-vm --privileged -p 9001:9000 -p 8001:8000 -e ANTHROPIC_API_KEY=your-api-key-here shelley-vm
```

Then access Shelley at [http://localhost:9001](http://localhost:9001) instead.

### The page won't load

1. Make sure Docker Desktop is running
2. Check if the container is running: `docker ps`
3. If you don't see "shelley-vm" in the list, start it: `docker start shelley-vm`

### API key errors

Make sure you replaced `your-api-key-here` with your actual API key when running the `docker run` command. If you need to fix it, remove the container and create it again:

```
docker rm shelley-vm
docker run -d --name shelley-vm --privileged -p 9000:9000 -p 8000:8000 -e ANTHROPIC_API_KEY=your-actual-key shelley-vm
```

## Keeping your work

By default, your projects are stored inside Docker. To keep your work even if you delete the container, use this command instead of the one in Step 7:

```
docker run -d --name shelley-vm --privileged -p 9000:9000 -p 8000:8000 -e ANTHROPIC_API_KEY=your-api-key-here -v ~/shelley-data:/data shelley-vm
```

This saves your work in a folder called `shelley-data` in your home directory.

## Sharing your app with others

Want to show someone what you've built? You can use ngrok to create a public link to your app.

### Install ngrok

1. Go to [ngrok.com](https://ngrok.com/)
2. Click **Sign up** and create a free account
3. After signing in, go to [dashboard.ngrok.com/get-started/setup](https://dashboard.ngrok.com/get-started/setup)
4. Under "Download ngrok", click the download for **Mac**
5. Unzip the downloaded file
6. Move the `ngrok` file to your Applications folder (or anywhere you like)

### Connect ngrok to your account

1. On the ngrok dashboard, find your **authtoken** (it's on the setup page)
2. Open Terminal and run this command, replacing `your-authtoken` with the token from the dashboard:

```
~/Applications/ngrok config add-authtoken your-authtoken
```

(Adjust the path if you put ngrok somewhere else)

### Share your app

When you have an app running at localhost:8000 and want to share it:

1. Open a **new** Terminal window (keep Shelley running in the other one)
2. Run:

```
~/Applications/ngrok http 8000
```

3. ngrok will show you a URL that looks like `https://abc123.ngrok-free.app`
4. Share that URL with anyone - they can see your app from their own device!

To stop sharing, press **Ctrl + C** in the Terminal window running ngrok.

**Note:** The free ngrok plan has some limits, but it's perfect for quick demos.

## Credits

- [Shelley](https://github.com/boldsoftware/shelley) by Bold Software
- [exeuntu](https://github.com/boldsoftware/exeuntu) base image by Bold Software
