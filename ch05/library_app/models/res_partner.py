from odoo import fields, models


class Partner(models.Model):
    _inherit = 'res.partner'
    _parent_store = True

    published_book_ids = fields.One2many(
        'library.book',  # related Model
        'publisher_id',  # field for "this" on related Model
        string='Published Books',
    )
