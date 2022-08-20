from flask import (
    Blueprint, flash, g, redirect, render_template, request,  url_for 
)
from blogflask.db import get_db
from blogflask.auth import login_required


bp = Blueprint('tag', __name__, url_prefix='/tag')


@bp.route('/all_tags')
def show_tags():
    db = get_db()
    tags = db.execute(
        'SELECT * FROM tag ORDER BY id'
    ).fetchall()
    return render_template('/tag/show_tags.html', tags=tags)


@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create_tag():
    if request.method == 'POST':
        title = request.form['title']
        error = None

        if not title:
            error = 'Title is required.'
        
        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO tag (title) VALUES (?)', (title,)
            )
            db.commit()
            return redirect(url_for('tag.create_tag'))

    return render_template('/tag/create.html')