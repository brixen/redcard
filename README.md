# RedCard

RedCard provides a standard way to ensure that the running Ruby implementation
matches the desired language version, implementation, and implementation
version.


## Why Do We Need It?

Once upon a time, Ruby was a very simple universe. There was a single Ruby
implementation and a single stable version. Now there are multiple current
language versions, multiple implementations, and numerous versions of those
multiple implementations.

In an ideal world, every Ruby implementation would provide the same features
and all such features would have consistent behavior. In the real world, this
is not the case. Hence, the need arises to have some facility for restricting
the conditions under which an application or library runs. RedCard provides
various mechanisms for specifying what language version, implementation, and
implementation version are required.


NOTE: In this documentation, Ruby version specifies the version of the Ruby
programming language itself. Historically, the word "Ruby" could have applied
to the language or the original implementation of the language. We refer to
the original implementation as MRI or Matz's Ruby Implementation. RedCard
distinguishes between Ruby language versions, Ruby implementations, and
implementation versions.


## Be Liberal

RedCard provides an API for specifying multiple implementations and versions.

    RedCard.check *requirements

The parameter, requirements, is an Array of Symbols or Strings with an
optional final Hash of implementations as keys and implementation versions as
values.

The following examples illustrate this:

    # Requires any version JRuby or Rubinius
    RedCard.check :rubinius, :jruby

    # Requires Ruby language 1.9 and MRI or Rubinius
    RedCard.check :mri, :rubinius, "1.9"

    # Requires Ruby language 1.9.3 or 2.0
    RedCard.check "1.9.3", "2.0"

    # Requires Ruby language 1.9 and Rubinius version 2.0
    RedCard.check "1.9", :rubinius => "2.0"


## Be Conservative

RedCard provides some convenience files that define restrictive requirements.
Using these, you can easily restrict the application to a single language
version, implementation, and implementation version.

The following examples illustrate this:

    # Requires at minimum Ruby version 1.9 but accepts anything greater
    require 'redcard/1.9'

    # Requires Rubinius 2.0
    require 'redcard/rubinius/2.0'

    # Requires Ruby 1.9 and Rubinius
    require 'redcard/1.9'
    require 'redcard/rubinius'

