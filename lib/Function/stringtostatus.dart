String stringToStatus(String status) {
  switch (status) {
    case '101':
      return 'pending';
    case '20':
      return 'feedback';
    case '30':
      return "acknowledged";
    case '102':
      return 'confirmed';
    case '50':
      return 'assigned';
    case '80':
      return 'resolved';
    case '103':
      return 'closed';
    default:
      return 'new';
  }
}
