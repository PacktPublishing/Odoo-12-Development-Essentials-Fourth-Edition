#!/usr/bin/env python3

from argparse import ArgumentParser
# from library_api import LibraryAPI
from library_odoorpc import LibraryAPI
# from library_erppeek import LibraryAPI

parser = ArgumentParser()
parser.add_argument(
    'command',
    choices=['list', 'add', 'set', 'del'])
parser.add_argument('params', nargs='*')
args = parser.parse_args()

srv, port, db = 'localhost', 8069, '12-library'
user, pwd = 'admin', 'admin'
api = LibraryAPI(srv, port, db, user, pwd)

if args.command == 'list':
    books = api.search_read()
    for book in books:
        print('%(id)d %(name)s' % book)

if args.command == 'add':
    for title in args.params:
        new_id = api.create(title)
        print('Book added with ID %d.' % new_id)

if args.command == 'set':
    if len(args.params) != 2:
        print("set command requires a Title and ID.")
    else:
        title, book_id = args.params[0], int(args.params[1])
        api.write(title, book_id)
        print('Title set for Book ID %d.' % book_id)

if args.command == 'del':
    for param in args.params:
        api.unlink(int(param))
        print('Book with ID %s was deleted.' % param)
