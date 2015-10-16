# ui-test package

testing using Etch and dom-listener

i have added bracket-templates as well. I plan on using it to handle c/c++
templates.


create new class
name
arguments
has destructor
virtual destructor
has copy constructor
has assignment op

inherits from
scope

use guardblock | pragma once

---------

class name {
  public:
    Name(args); //constructor
    virtual ~Name(); // destructor
    Name(const Name& other); // copy constructor
    Name& operator=(const Name& other); // assignment constructor
};

-----

#include "Name.h"

Name::Name(args) {

}

Name::Name~() {

}

Name::Name(const Name& other) {

}

Name& Name::operator=(const Name& rhs) {
    if (this == &rhs) return *this;   // handle self assignment
    // assignment operator
    return *this;
}
