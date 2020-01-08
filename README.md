# Github Actions and Workflows

## About this document
This repo is an example of how to use GitHub actions to automate useful things. This README is meant to provide a 
pedagogical introduction to how that works. By "pedagogical" I mean that this is the tutorial I wanted to find but 
couldn't. GitHub's own documentation is clearly written and comprehensive, but I found that the major concepts weren't 
laid out in the right order for me to absorb everything, and I had to go digging a bit until things clicked for me. YMMV. 
Plenty of other tutorials were basically lists of instructions of what to type, but were specific to the task being automated rather
than trying to explain the big picture. Hence, I wrote this up.

## What are they good for?
You want stuff to happen (like running your unit tests or deploying your app to production) 
triggered by some event in Github (like a pull request or someone pushing to master.)

Often there's some third party API that can set this up for you with a 
[webhook](https://developer.github.com/webhooks/). But perhaps there's not an API that fulfills your 
needs. Or maybe you can roll the functionality yourself and you don't need another monthly bill.

Enter the workflow.

## Workflows

A workflow is a way to execute tasks triggered by some event within GitHub. 
You define a workflow by a YAML file that lives in `$YOUR_PROJECT_ROOT_DIR/.github/workflows`; 
this project has one you can check out.

A workflow has a `name`, and an `on` trigger that specifies when it gets run:

```yaml
name: My first workflow

on: push
```

The instructions in a workflow are comprised of **jobs**. Each job tells GitHub 
to carry out a set of instructions on some host machine. This might be a server you own, or it 
might be some virtual host that gets set up just to run your instructions and cleaned up afterwards.

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



## Useful references
https://andycroll.com/ruby/github-actions-ci-for-rails-with-postgresql/

