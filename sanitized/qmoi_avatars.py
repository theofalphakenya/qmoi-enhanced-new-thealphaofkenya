"""Sanitized stub for avatars content.

Placeholder module that returns preserved document text.
"""

from pathlib import Path

def get_notes():
    p = Path(__file__).resolve().parent.parent / 'docs' / 'converted' / 'qmoi_doctexts.md'
    if p.exists():
        return p.read_text(encoding='utf-8')
    return ''

__all__ = ['get_notes']
