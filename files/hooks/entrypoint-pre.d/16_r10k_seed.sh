#!/bin/sh

echo "Seeding environments"
scl enable rh-ruby23 "r10k deploy environment -pv"
