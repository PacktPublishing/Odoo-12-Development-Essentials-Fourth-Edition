from odoo.tests.common import TransactionCase

class TestBook(TransactionCase):

    def test_check_isbn10(self):
        "Check valid ISBN-10"
        Book = self.env['library.book']
        book = Book.create({
            'name': 'The Pythons: Autobiography by the Pythons',
            'isbn': '0312311443',
        })
        self.assertTrue(book._check_isbn())
