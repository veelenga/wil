**GoF** patterns implemented in *Ruby*. Has learning purpose.

There is a list of similar reporsitories in different languages:
* [java-design-patterns](https://github.com/iluwatar/java-design-patterns)
* [design-patterns-in-ruby](https://github.com/nslocum/design-patterns-in-ruby)
* [javascript-patterns](https://github.com/shichuan/javascript-patterns.git)
* ...

Some examples implemented based on samples from book **Design Patterns in Ruby - Russ Olsen, 2007**.

* [Main aspects] (#main-oop-aspects)
* [Template method] (#template-method)
* [Strategy] (#strategy)

## Main aspects:

1. Separate the things that change from those that stay the same:
  * improves maintainability
  * easier to introduce a change
  * promotes DRY code

2. Program to an interface, not an implementation:
  * increases modularity
  * code becomes more change resistant

3. Prefer composition over inheritance:
  * increases encapsulation
  * increases usability

4. Delegate, delegate, delegate:
  * flexibility

  **Note**: there is a cost of delegation - extra method call and boilerplate code.

5. You ain't gonna need it:

  Do not implement things that you don't need.

## Template method

![](template-method/template-method.png)

Method pattern is simply a fancy way of saying that if you want to vary an algorithm, one way to do so is to code the invariant part in a base class and to encapsulate the variable parts in methods that are defined by a number of subclasses.

**Note**: duck typing has an important role here for dynamic languages.

Disadvantage: no runtime change.

## Strategy

![] (strategy/strategy.png)

Key idea is to define a family of objects, the **strategies**, which all do the same thing and all support the same interface. There is a user of the strategies - **context** - can treat the strategies like interchangeable parts.

  * switch strategies in runtime
  * better separation of concerns by pulling out a set of strategies

**Note**: with Ruby we have 'quick and dirty' way to define strategy pattern using `Proc`s. But code-block strategies work only when the strategy interface is simple, one method affair.
