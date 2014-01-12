# vagrant-host-ruby-provisioner

## Description

Vagrant Ruby provisioner for executing Ruby code on the host.

## Usage

```ruby
Vagrant.configure '2' do |configure|
  # ...

  configure.vm.provision :host_ruby do |ruby|
    ruby.routine = lambda { puts 'Hello world!' }
  end

  # ...
end
```

### Configuration

 - `clean`: The cleanup routine to be executed. __Default:__ `lambda {}`.
 - `cwd`: The current working directory. __Default:__ `nil` (which makes it the directory containing "__Vagrantfile__").
 - `routine`: The main routine to be executed. __Required__.

## Tests

Given the size and scope of this project, I don't see any immediate need for tests. Feel free to disagree :) .

## Contributors

__[Jonathan Barronville](mailto:jonathan.barronville@jebbit.com "jonathan.barronville@jebbit.com")__

## License

See "__LICENSE__".