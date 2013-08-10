# FilterableSortable

Gem generates :filtered and :sorted scopes, can be easily used for building admin zone or other filterable sortable architecture.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filterable_sortable'
```

And then execute:

```console
bundle
```

Or install it yourself as:

```console
gem install filterable_sortable
```

## Usage

### Models

First of all include module into ActiveRecord::Base inherited class

```ruby
include FilterableSortable
```

### Controllers

In controllers add scopes to index action. I use 'will_paginate' gem, so here is method *.paginate(...)

```ruby
@posts = Post.filtered(params[:filter]).ordered(params[:order]).paginate(page: params[:page], per_page: params[:per_page])
```

### Views

In views you can use links with params for order and filter. Example in Haml.

```ruby
= link_to 'Name', posts_path(filter: :name, order: {field: :name, direction: :ASC})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
