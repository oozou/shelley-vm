# Shelley-VM

A ready-to-use development environment with [Shelley](https://github.com/boldsoftware/shelley), an AI coding assistant powered by Claude. Describe what you want to build, and Shelley writes the code for you.

## How AI coding assistants work

### What is an LLM?

LLM stands for "Large Language Model" - it's the technology behind AI assistants like Claude, ChatGPT, and others. Think of it as a very sophisticated autocomplete: you give it text, and it predicts what should come next. But because it was trained on enormous amounts of text (books, code, websites), it can do much more than simple autocomplete - it can write code, explain concepts, and solve problems.

### What is a "model"?

A model is a specific version of an LLM. Anthropic (the company behind Claude) offers several models:

- **Claude Opus 4** - The most capable model, best for complex tasks
- **Claude Sonnet 4** - A good balance of capability and speed
- **Claude Haiku 3.5** - The fastest and cheapest, good for simpler tasks

Shelley uses the Claude API to send your requests to these models and get responses back.

### How much does it cost?

Using the API costs money based on how much text you send and receive (measured in "tokens" - roughly 4 characters per token). Current pricing for Claude Sonnet 4:

- Input (what you send): $3 per million tokens
- Output (what Claude writes): $15 per million tokens

For building a simple app, expect to spend $0.50 to $5 depending on complexity. You can monitor your usage at [console.anthropic.com](https://console.anthropic.com/).

### Shelley vs Claude Code

There are different ways to use Claude for coding:

**Shelley (what we're setting up here)**
- Runs in a browser - no coding experience needed
- Works autonomously - just describe what you want and let it build
- Runs inside a virtual machine (VM), so it can't accidentally damage your computer
- If something goes wrong, just delete the VM and start fresh

**Claude Code**
- Runs directly on your computer via the terminal
- More powerful and flexible, but requires more technical knowledge
- Asks for permission before running commands (because it could affect your actual files)
- Better for experienced developers who want more control

We're starting with Shelley because it's safer and easier. The VM acts as a sandbox - Shelley can run any command it needs without asking permission, because the worst case scenario is it breaks the VM (which you can just recreate). On your real computer, you'd want those safety checks.

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

## Prompting guide

### What is a prompt?

A "prompt" is simply what you type to tell Shelley what to do. It's your instruction or request. The better you describe what you want, the better results you'll get.

### What is context?

"Context" is everything Shelley knows about your current conversation - all the messages you've sent, all the code it's written, and all the files it's seen. Think of it like Shelley's short-term memory for this project.

Context has a limit. As you keep chatting and building, eventually the conversation gets too long and Shelley might start forgetting earlier details or get confused. When this happens, it's time to start a new agent (see below).

### Starting a new agent

In Shelley, you can start a new conversation by clicking **"New Agent"** in the interface. Do this when:

- The current conversation is getting long and Shelley seems confused
- You want to start a completely different project
- Shelley is stuck in a loop or keeps making the same mistakes

Starting fresh gives Shelley a clean slate. If you're continuing work on an existing project, just tell the new agent what files to look at: "Look at the project in /root/my-app and add a login page."

### Tips for better prompts

**Be specific about what you want:**
- Vague: "Make a website"
- Better: "Create a Next.js app with a homepage that shows a list of blog posts"

**Mention the technologies you want:**
- "Use Next.js with TypeScript and Tailwind CSS"
- "Create a React component using shadcn/ui"

**Describe the end result:**
- "When I click the button, it should show a loading spinner, then display the results"

**Break complex projects into steps:**
- First: "Create a Next.js app with a basic layout"
- Then: "Add a form to create new posts"
- Then: "Add the ability to edit and delete posts"

### Example prompts

**Simple web apps:**

> Create a Next.js app with a todo list. I should be able to add items, mark them as done, and delete them. Use Tailwind CSS for styling. Store the todos in local storage so they persist when I refresh the page.

> Build a React app that shows the current weather. Use the OpenWeatherMap API (here's my API key: xxx). Show temperature, humidity, and a weather icon. Let me search for different cities.

**Using third-party APIs:**

> Create a Next.js app with an interactive map using Mapbox. Here's my Mapbox access token: pk.xxx. Let me click on the map to drop pins and save locations with names.

> Build a recipe app that uses the Spoonacular API to search for recipes. My API key is xxx. Show recipe cards with images and let me click to see full instructions.

**Working with existing code:**

> Look at the project in /root/my-app. Add a dark mode toggle that saves the preference to local storage.

> Check out the code in /root/my-website. The contact form isn't sending emails - can you fix it and show me what was wrong?

**Adding tests:**

> Look at the project in /root/my-app. Add Jest tests for all the utility functions in the /utils folder.

> Review the React components in /root/my-app/components and add React Testing Library tests for each one. Focus on testing user interactions.

**Learning and exploring:**

> I have a Next.js project in /root/my-app. Explain how the authentication flow works - walk me through what happens when a user logs in.

> Look at /root/my-app/api and explain what each API endpoint does.

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

### Getting files out of the VM

If you started the VM without linking a directory (using the command in Step 7), your files are still inside the container. Here's how to copy them to your Mac:

**Copy a single file:**

```
docker cp shelley-vm:/path/to/file.txt ~/Desktop/
```

For example, to copy a file called `app.py` from the home directory:

```
docker cp shelley-vm:/root/app.py ~/Desktop/
```

**Copy an entire folder:**

```
docker cp shelley-vm:/root/my-project ~/Desktop/
```

This copies the `my-project` folder to your Desktop.

**Find where your files are:**

If you're not sure where Shelley put your files, you can look inside the VM:

```
docker exec -it shelley-vm /bin/bash
```

This opens a command prompt inside the VM. You can use `ls` to list files and `cd` to navigate. Type `exit` when you're done.

**Tip:** Shelley typically creates projects in `/root/` (the home directory inside the VM).

### Exposing additional ports

The VM only exposes ports 9000 (Shelley) and 8000 (your app) by default. If your app uses a different port (like 3001), you can't just add a port to a running container - you need to recreate it.

**Don't worry, your files are safe!** Here's how to do it:

1. First, copy your project files out of the VM (so you don't lose them):

```
docker cp shelley-vm:/root ~/Desktop/shelley-backup
```

2. Stop and remove the old container:

```
docker stop shelley-vm
docker rm shelley-vm
```

3. Start a new container with the additional port (add `-p 3001:3001` or whatever port you need):

```
docker run -d --name shelley-vm --privileged -p 9000:9000 -p 8000:8000 -p 3001:3001 -e ANTHROPIC_API_KEY=your-api-key-here shelley-vm
```

4. Copy your files back into the VM:

```
docker cp ~/Desktop/shelley-backup/. shelley-vm:/root/
```

**Pro tip:** To avoid this in the future, you can expose a range of ports when first creating the container:

```
docker run -d --name shelley-vm --privileged -p 9000:9000 -p 8000-8010:8000-8010 -p 3000-3010:3000-3010 -e ANTHROPIC_API_KEY=your-api-key-here shelley-vm
```

This exposes ports 8000-8010 and 3000-3010, so you're ready for whatever port your app needs.

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
