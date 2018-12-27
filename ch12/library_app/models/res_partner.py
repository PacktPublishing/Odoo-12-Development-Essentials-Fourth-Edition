from odoo import fields, models


class Partner(models.Model):
    _inherit = 'res.partner'

    published_book_ids = fields.One2many(
        'library.book',  # related model
        'publisher_id',  # field for "this" on related model
        string='Published Books')

    book_ids = fields.Many2many(
        'library.book', string='Authored Books')
