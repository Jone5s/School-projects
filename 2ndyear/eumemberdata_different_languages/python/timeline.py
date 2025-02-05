import sys
from datetime import date, datetime, timedelta
from collections import defaultdict
from typing import List, Dict, Optional

import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import numpy as np

from eumembers import load_data, concatenated, EventKind

def get_date_range(dates):
    sorted_dates = sorted(dates)
    return sorted_dates[0], sorted_dates[-1]

# This timeline is based on https://matplotlib.org/stable/gallery/lines_bars_and_markers/timeline.html
def make_timeline(events):
    date_strs = sorted(list(events.keys()))
    dates = [datetime.fromisoformat(d) for d in date_strs]

    labels: List[str] = []
    for d in date_strs:
        date_events = defaultdict(list)
        for event in events[d]:
            date_events[event.kind].append(event)

        for event_kind in EventKind.list():
            if event_kind in date_events:
                date_events[event_kind].sort(key=lambda e: e.country_name)

        for event_kind in date_events:
            country_names = [e.country_name for e in date_events[event_kind]]
            labels.append(f'{event.date}:\n{concatenated(country_names)} {event.kind}')

    # Choose some nice levels
    levels = np.tile([-5, 5, -3, 3, -1, 1], int(np.ceil(len(dates)/6)))[:len(dates)]

    # Create figure and plot a stem plot with the date
    fig, ax = plt.subplots(figsize=(8.8, 4), constrained_layout=True)
    ax.set(title="European Union Timeline")

    ax.vlines(dates, 0, levels, color="tab:blue")  # The vertical stems.
    ax.plot(dates, np.zeros_like(dates), "-o",
        color="k", markerfacecolor="w")  # Baseline and markers on it.

    # annotate lines
    for d, l, r in zip(dates, levels, labels):
        ax.annotate(r, xy=(d, l),
            xytext=(-3, np.sign(l)*3), textcoords="offset points",
            horizontalalignment="right",
            verticalalignment="bottom" if l > 0 else "top")

    # format xaxis with 12-month intervals
    ax.xaxis.set_major_locator(mdates.MonthLocator(interval=12))
    ax.xaxis.set_major_formatter(mdates.DateFormatter("%b %Y"))
    plt.setp(ax.get_xticklabels(), rotation=30, ha="right")

    # remove y axis and spines
    ax.yaxis.set_visible(False)
    ax.spines[["left", "top", "right"]].set_visible(False)

    ax.margins(y=0.1)

    plt.show()

# This timeline is based on https://dadoverflow.com/2021/08/17/making-timelines-with-python/
def make_timeline_0(events):
    date_strs = sorted(list(events.keys()))
    dates = [datetime.fromisoformat(d) for d in sorted(list(events.keys()))]
    min_date = date(dates[0].year - 2, dates[0].month, dates[0].day)
    max_date = date(dates[-1].year + 2, dates[-1].month, dates[-1].day)

    labels: List[str] = []

    for d in date_strs:
        date_events = defaultdict(list)
        for event in events[d]:
            date_events[event.kind].append(event)

        for event_kind in EventKind.list():
            if event_kind in date_events:
                date_events[event_kind].sort(key=lambda e: e.country_name)

        for event_kind in date_events:
            country_names = [e.country_name for e in date_events[event_kind]]
            labels.append(f'{event.date}:\n{concatenated(country_names)} {event.kind}')

    # Reverse dates and labels for vertical timeline
    dates.reverse()
    labels.reverse()
    print(dates, labels)

    fig, ax = plt.subplots(figsize=(6, 10), constrained_layout=True)
    _ = ax.set_xlim(-20, 20)
    _ = ax.set_ylim(min_date, max_date)
    _ = ax.axvline(0, ymin=0.05, ymax=0.95, c='deeppink', zorder=1)
    _ = ax.scatter(np.zeros(len(dates)), dates, s=120, c='palevioletred', zorder=2)
    _ = ax.scatter(np.zeros(len(dates)), dates, s=30, c='darkmagenta', zorder=3)

    label_offsets = np.repeat(2.0, len(dates))
    label_offsets[1::2] = -2.0
    for i, (l, d) in enumerate(zip(labels, dates)):
        d = d - timedelta(days=90)
        align = 'right'
        if i % 2 == 0:
            align = 'left'
        _ = ax.text(label_offsets[i], d, l, ha=align, fontfamily='serif', fontweight='bold', color='royalblue',fontsize=12)

    stems = np.repeat(2.0, len(dates))
    stems[1::2] = -1.0
    x = ax.hlines(dates, 0, stems, color='darkmagenta')

    # hide lines around chart
    for spine in ["left", "top", "right", "bottom"]:
        _ = ax.spines[spine].set_visible(False)

    # hide tick labels
    _ = ax.set_xticks([])
    _ = ax.set_yticks([])

    _ = ax.set_title('European Union Timeline', fontweight="bold", fontfamily='serif', fontsize=16, color='royalblue')

    plt.show()

if __name__ == '__main__':
    if len(sys.argv) < 2: #
        print('Need at least the SQLite database file name.')
        sys.exit(-1)

    db_name = sys.argv[1]
    #print(f'using database file "{db_name}"')

    all_events = load_data(db_name)
    make_timeline(all_events)
