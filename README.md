[![CI](https://github.com/qsimpleq/assignment-funbox-nmax/actions/workflows/main.yml/badge.svg)](https://github.com/qsimpleq/assignment-funbox-nmax/actions/workflows/main.yml)

# Nmax

The `nmax` script reads text data from an incoming stream,\
at the end of the input it outputs the `n` largest integers encountered in the received text data


<details><summary>Формулировка ТЗ под спойлером</summary>

[ссылка на основной репозиторий](https://github.com/qsimpleq/assignment-funbox-ruby-rails-developer#1-%D0%BD%D0%B0%D0%BF%D0%B8%D1%88%D0%B8%D1%82%D0%B5-%D1%81%D0%BA%D1%80%D0%B8%D0%BF%D1%82-nmax-%D0%BA%D0%BE%D1%82%D0%BE%D1%80%D1%8B%D0%B9-%D0%B4%D0%B5%D0%BB%D0%B0%D0%B5%D1%82-%D1%81%D0%BB%D0%B5%D0%B4%D1%83%D1%8E%D1%89%D0%B5%D0%B5)

# Напишите скрипт nmax, который делает следующее:
* читает из входящего потока текстовые данные
* по завершении ввода выводит n самых больших целых чисел, встретившихся в полученных текстовых данных.

Дополнительные указания:
* числом считается любая непрерывная последовательность цифр в тексте
* известно, что чисел длиннее 1000 цифр во входных данных нет
* число n должно быть единственным параметром скрипта
* код должен быть покрыт тестами
* код должен быть оформлен в виде гема (содержащего исполняемый файл, код модулей и т.д.)
* плюсом является размещение на Github и интеграция с Travis CI.
</details>

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add nmax --git 'https://github.com/qsimpleq/assignment-funbox-nmax.git'

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install specific_install 
    $ gem specific_install -l 'https://github.com/qsimpleq/assignment-funbox-nmax.git'

## Usage

```shell
cat sample_data_40GB.txt | nmax 10000
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qsimpleq/assignment-funbox-nmax. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/qsimpleq/assignment-funbox-nmax/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Nmax project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/qsimpleq/assignment-funbox-nmax/blob/master/CODE_OF_CONDUCT.md).
