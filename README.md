# Futon

Restore/wrap up your repositories and workspaces like a futon.

Restore only repositories/workspaces you need to work on. Safely delete or wrap up anything else.

## Why a new project?

- [Puppet](puppetlabs.com) is for servers, not developers (it clobbers repositories or needs complex custom modules)
- [Repo] (https://source.android.com/source/using-repo.html) is for related repositories and extending it is troublesome
- [myrepos](http://myrepos.branchable.com/) is close (!), except it emphasises push/pull on multiple repositories, while futon is more about backup/restore/"safely-implode"
- [git-sweep](https://github.com/arc90/git-sweep) only cleans up a repo, no backup, no restore, no switching between sets of projects
- dotfiles managers - mostly only for retrieving and updating, not many storage options
- custom shell scripts - we all know what happens with them...

## Installation

    $ gem install futon

## Usage

Create a `~/.futon/default.yml` with a configuration like this:

```
---
:workspaces:
  myproject1:
    :directory: '/home/user/workspace/myproject1'
    :source:
      type: :git
      :url: "https://example.org/myproject.git"
```

And run `futon` to restore those defined projects.


## Features

- [x] Restore git workspace from global ~/.futon/default.yml
- [x] Project ready for heavy development (RSpec tests, Guard, RuboCop, Docker acceptance test)
- [x] Initial gem release
- [ ] Per-project settings
- [ ] Alternative config file on command line
- [ ] "Unrestore" repo (safely remove if full backup is available)
- [ ] Tagging and switching whole sets on/off
- [ ] smart "out of sight" git repo cache for fast checkouts/updates
- [ ] Support S3 providers (with IAM auth)
- [ ] Support for tarball/gpg/ssh/rsync providers
- [ ] "Fetch" command on specified sets of repos
- [ ] Support mixed backup when files are modified, stashed or in local branches

These will likely be added soon, though PRs and issues reports are welcome if you can't wait!

## Development

After checking out the repo, run `bin/setup` to install dependencies. 
Then, run `rake spec` to run the tests.
For TDD/BDD workflow, run `bin/guard`.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/futon.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

