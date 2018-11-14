from odoo.tests.common import TransactionCase


class TestBook(TransactionCase):

    def setUp(self, *args, **kwargs):
        result = super(TestBook, self).setUp(*args, **kwargs)
        # Prepare environment with the Admin user
        user_admin = self.env.ref('base.user_admin')
        self.env = self.env(user=user_admin)
        # Setup test data
        self.Book = self.env['library.book']
        self.book_ode = self.Book.create({
            'name': 'Odoo Development Essentials',
            'isbn': '978-1-78439-279-6'})
        return result

    def test_create(self):
        "Test Books are active by default"
        self.assertEqual(self.book_ode.active, True)

    def test_check_isbn(self):
        "Check valid ISBN"
        self.assertTrue(self.book_ode._check_isbn())
