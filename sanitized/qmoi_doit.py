"""Sanitized stub for doit content.

This module is a small accessor that loads the extracted documentation at
`docs/converted/qmoi_doctexts.md`. It intentionally contains no executable
application logic.
"""

from pathlib import Path

def get_notes():
    p = Path(__file__).resolve().parent.parent / 'docs' / 'converted' / 'qmoi_doctexts.md'
    if p.exists():
        return p.read_text(encoding='utf-8')
    return ''

__all__ = ['get_notes']
