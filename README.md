# GitHub Actions and Workflows

## About this document
This repo is an example of how to use GitHub actions to automate useful things, by running tests whenever someone pushes to it.
 This README is meant to provide a pedagogical introduction to how that works. 
 
 By "pedagogical" I mean that this is the tutorial I wanted to find but couldn't. GitHub's own documentation is clearly written and 
 comprehensive, but I found that the major concepts weren't laid out in the right order for me to absorb everything, 
 and I had to go digging a bit until things clicked for me. YMMV. 
 
Plenty of other tutorials were basically helpful lists of instructions of what to type, but were specific to the task being automated 
rather than trying to explain the big picture. A list of the ones I found useful can be found below. 

Hence, I wrote this up. Note that it's a work in progress. Please feel free to 
open an issue if you find something unclear or think I've got something wrong.

## What are they good for?
You want stuff to happen (like running your unit tests or deploying your app to production) 
triggered by some event in GitHub (like a pull request or someone pushing to master.)

Often there's some third party API that can set this up for you with a 
[webhook](https://developer.github.com/webhooks/). But perhaps there's not an API that fulfills your 
needs. Or maybe you can roll the functionality yourself and you don't need another monthly bill.

Enter the workflow.

## Workflows

A workflow is a way to execute tasks triggered by some event within GitHub. 
You define a workflow by a YAML file that lives in `$YOUR_PROJECT_ROOT_DIR/.github/workflows`; 
this project has one you can check out. If you're unfamiliar with YAML, see 
[a five minute tutorial](https://www.codeproject.com/Articles/1214409/Learn-YAML-in-five-minutes).

A workflow has a `name`, and an `on` trigger that specifies when it gets run:

```yaml
name: My first workflow

on: push
```

The instructions in a workflow are comprised of **jobs**. Each job tells GitHub 
to carry out a set of instructions on some host machine, which in this context is called a **runner**. 
This might be a server you own, or it might be some virtual host machine that gets set up just to run your 
instructions and cleaned up afterwards.

The instructions in an individual job are called **steps**.

## Defining jobs
A minimal specification of a single job named `my-first-job`, comprised of a single step, within a workflow: 
```yaml
jobs:
  my_first_job:
    runs-on: ubuntu-latest # specify the OS for our machine.

    steps:
      - name: Print a dumb greeting
        run: echo 'Hello world'
```

This job isn't very useful - it powers up a virtual host just to run the single bash command `echo 'Hello world'`, then
tears it down again. But you do at least get to see the output by visiting the *Actions* tab of your repo. You can see 
the output of this simple job
[here](https://github.com/robwold/rails-GH-actions-demo/commit/d48da7e75c74c92071edc2e41b599c69761d4dc9/checks?check_suite_id=390732045)
. 

To actually do useful stuff, we need to define more interesting steps.

## Defining steps
Our example step above just had a `name`, and a `run` command. We can also set `env` variables in a step.
Our `run` command was a single line. To define a sequence of bash instructions instead we can use the pipe operator `|`:
```yaml
    - name: A simple calculator
      env:
        TWO: 2
      run: |
        SUM=$(($TWO + $TWO))
        echo 'two and two makes' $SUM
```

As an alternative to defining bash commands with `run`, we can also use GitHub **actions**. 
An action is a workflow step defined by a re-usable module of code. Actions are published with a versioning 
scheme `{owner}/{repo}@{ref}`, and invoked with the `uses` command. For example, if we want to checkout our 
repo on our runner, GitHub has provided us with an action :
```yaml
    - uses: actions/checkout@v1
```

The name tells us that we're getting the action defined in 
[this repo](https://github.com/actions/checkout).
We `name` actions and can provide arguments using the `with` key, like this:
```yaml
      - name: Set up Ruby 2.6
        uses: actions/setup-ruby@v1
        with:
          ruby-version: 2.6.x
```
where we use an argument to tell the action which version of Ruby we want to install on our system.

To write an action, see [here](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/building-actions).
Note that you can [define an action within your repo](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/about-actions#choosing-a-location-for-your-action)
instead of publishing it as a separate module.

## About this example project
**TODO**

## Useful references
https://help.github.com/en/actions
https://andycroll.com/ruby/github-actions-ci-for-rails-with-postgresql/
https://andycroll.com/ruby/github-actions-ci-for-rails-with-specific-ruby-versions
https://firefart.at/post/using-mysql-service-with-github-actions/

