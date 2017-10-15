# Gemini

A resource-oriented framework for learning how to build web application prototypes
without the usual Rails hurdles, by providing a beginner-friendly directory structure on top
of an internal, hidden, preconfigured Rails application.  

See the Known Limitations list below.

### Goals

Gemini is a beginner-friendly steppingstone to Rails.

The primary goals of this framework are to enable students to focus on:

* The concept of HTTP resources
* The basics of programming, using Ruby
* The essentials of the HTTP 1.x request-response cycle
* The core ideas of relational databases



### Commmands

`./gemini build`

`./gemini server`

`./gemini console`

### Getting Started

* Use `layout.html.erb` as you application layout file.
* Define your database using `models.yml`
* Create a new resource by creating a subfolder.  Follow Rails naming conventions: `/movies`, `/actors`, etc.
* All of your code goes inside of the appropriate resource folder.  See details below.

### Resources

Inside of any given resource folder, all of the following are permitted:

* A _RESTful_ view (`index.html.erb`, `show.html.erb`, etc.)
* Any other view for `GET` access only
* A _RESTful_ action handler (`index.rb`, `show.rb`, etc.)
* A _RESTful_ JSON responder (`index.json.jbuilder`, `show.json.jbuilder`, etc.)
* A model file, that must be named `model.rb`

### Action Handlers

Think of these as the bare bones of a single controller method, without the Ruby method definition.

For example, here's a typical `/products/index.rb`:

``` ruby
@products = Product.all
@in_stock = Product.in_stock
```

These variables can now be used in `/products/index.html.erb`.

### Model Files

Think of these as the bare bones of a single model class, without the Ruby class definition.

All associations are automatically generated and should not appear in this file.  No need for `has_many`, etc.

Here's a typical `/products/model.rb`:

``` ruby
validates :sku, presence: true

before_save :adjust_price

def adjust_price
  self.price *= 1.8 if self.markup?
end
```

Notice the lack of `class...end` syntax, but everything else is supported.


### Known Limitations

At this time:

* View code is reloaded automatically, but `model.rb` files are not.  Use `./gemini build`.
* Migrations are not run automatically.  Use `./gemini build` whenever you change `models.yml`.
* Not Implemented: `before_action`
* Not Implemented: view helpers
* Not Implemented: user signup/login/logout
* Non-RESTful views cannot have action handlers.
* Stopping the server with Ctrl-C currently results in an ugly backtrace (not harmful).
