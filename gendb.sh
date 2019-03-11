#!/usr/bin/env bash

rm db.db
sqlite3 db.db < schema.sql
