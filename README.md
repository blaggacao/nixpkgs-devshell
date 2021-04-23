# nixpkgs-devshell - a development environment for NixOS/nixpkgs

**STATUS: unstable**

A decent way to get/stay productive when contributing to `NixOS/nixpkgs`.

Unless owning a huge body of experience, when contributing to `NixOS/nixpkgs`,
you wonder:

- What's the currently "blessed" way of adding a say golang package? _(tbd via nix flake templates)_
- Where should that go within the folder hierarchy? _(tbd via a small interactive utility script)_
- How exactly do I properly test my prototype?
- Is the formatting in line with the current best practises?
- How to best deal with the github process (and the overwhelming amount of issues / prs)?


To find an answer to any of those questions, you could read through the manual,
skim through github issues or scan the forum for clues and riddles.

You might even make a new friend along your quest.

But, if all you want to do is to get productive with your contributing job,
this devshell provides you with a decent environment to start with.
And in addition to a new friend, you might discover a tool or workflow
that you didn't know before and that helps you get that contributing job 
done as effectively as possible.

```console

$ cd NixOS/nixpkgs # your local clone of NixOS/nixpkgs

$ nix develop github:blaggacao/nixpkgs-devshell

🔨 Welcome to nixpkgs

[general commands]

  menu                 - prints this menu

[github]

  bugs                 - List issues labeled as bugs
  gh                   - GitHub CLI tool
  issue-status         - Information about relevant issues
  packaging-requests   - List issues labeled as packaging requests (chill out work)
  pr-status            - Information about relevant PRs

[linters]

  editorconfig-checker - A tool to verify that your files are in harmony with your .editorconfig
  evalnix              - Check Nix parsing
  fmt                  - Check Nix formatting

[workflow]

  review               - Review pull-requests on https://github.com/NixOS/nixpkgs
  update               - Swiss-knife for updating nix packages

[nixpkgs]$
```

## How it works

nixpkgs-devshell, at its heart, is an opinionated [`devshell`](https://github.com/numtide/devshell):
* it provides a pre-selected set of ecosystem tooling that reflects current best practises
* it shows a practical message of the day, as the first point of contact
* it gradually might hold a growing collection of language-specific nix flake templates, as 
  language subsystem maintainers begin to percive the value of submitting and maintaining them. (Please do! :wink:)

## Future development

- a way for language subsystems to provide up-to-date and authoritative templates / examples
- an interactive helper to navigate the nixpkgs folder hierarchy
- provide an environment flag to disable the message of the day

# License

Copyright (c) 2021 David Arnold under the MIT.

